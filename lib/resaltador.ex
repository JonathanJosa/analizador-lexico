defmodule Resaltador do

  def init do
    {:ok, file} = File.open("web/index.html", [:write])
    IO.write(file," <link rel='stylesheet' href='styles.css'>")
    IO.write(file,"<br><pre><code> <span style='color:#C19875'> ·</span> ")
    File.read("web/file.ex") |> elem(1) |> String.to_charlist() |> :lexer.string() |> elem(1) |> main(file)
    IO.write(file,"</code></pre><br>")
  end

  def main([], _), do: true
  def main([{token, _, chars} | tail], file) do
    editor(file, token, chars)
    if (Enum.member?(['def','defmodule'], chars)), do: funciones(file, tail), else: main(tail, file)
  end

  def funciones(_, []), do: true
  def funciones(file, [{_,_,'('}|tail]) do
    IO.write(file, "<span style='color:#9A8BBB;'>"<> to_string('(') <> "</span>")
    parametros(file, tail)
  end
  def funciones(file, [{_,_,chars}|tail]) do
    if (Enum.member?(['do:', 'do'], chars)) do
      IO.write(file, "<span style='color:#1098F7;'>"<> to_string(chars) <> "</span>")
      main(tail, file)
    else
      IO.write(file, "<span style='color:#9A8BBB;'>"<> to_string(chars) <> "</span>")
      funciones(file,tail)
    end
  end

  def parametros(_,[]), do: true
  def parametros(file,[{_,_,')'}|tail]) do
    IO.write(file, "<span style='color:#9A8BBB;'>"<> to_string(')') <> "</span>")
    funciones(file, tail)
  end
  def parametros(file,[{token,_,chars}|tail]) do
    indicador(file, token, chars)
    parametros(file, tail)
  end

  def indicador(file, :atom, chars), do: IO.write(file, "<span style='color:#EAC435;'>"<> to_string(chars) <> "</span>")
  def indicador(file, :dot, chars), do: IO.write(file, "<span style='color:#9A8BBB;'>"<> to_string(chars) <> "</span>")
  def indicador(file, _, chars), do: IO.write(file, "<span style='color:#03DDB2;'>"<> to_string(chars) <> "</span>")


  def editor(file, _, '\n'), do: IO.write(file, "\n <span style='color:#C19875'> ·</span> ")
  def editor(file, :textC, chars), do: IO.write(file, to_string(chars))
  def editor(file, :atom, chars), do: IO.write(file, "<span style='color:#EAC435;'><i>"<> to_string(chars) <> "</i></span>")
  def editor(file, :comentario, chars), do: IO.write(file, "<span style='color:#565857;'><i>"<> to_string(chars) <> "</i></span>")
  def editor(file, :pipe, _), do: IO.write(file, "<span style='color:#B80C09;'>|></span>")
  def editor(file, :keyword, chars), do: IO.write(file, "<span style='color:#1098F7;'>"<> to_string(chars) <> "</span>")
  def editor(file, :bool, chars), do: IO.write(file, "<span style='color:#4ECDC4;'><i>"<> to_string(chars) <> "</i></span>")
  def editor(file, :dot, chars), do: IO.write(file,  "<span style='color:#FBFBFF;'>"<> to_string(chars) <> "</span>")
  def editor(file, :funcion, chars), do: IO.write(file, "<span style='color:#D7B884;'>"<> to_string(chars) <> "</span>")
  def editor(file, :module, chars), do: IO.write(file, "<span style='color:#C73E1D;'>"<> to_string(chars) <> "</span>")
  def editor(file, :tiempo, chars), do: IO.write(file, "<span style='color:#FFAD69;'>"<> to_string(chars) <> "</span>")
  def editor(file, :bitwise, chars), do: IO.write(file, "<span style='color:#EE7B30;'>"<> to_string(chars) <> "</span>")
  def editor(file, _, chars), do:  IO.write(file, "<span style='color:#FBFBFF;'>"<> to_string(chars) <> "</span>")
end
