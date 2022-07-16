defmodule File do
  #Archivo de ejemplo que no compila, pero si usa palabras clave o funciones

  def funcion(_), do: true
  def funcion(:atomo, parametro, "abc", 'abc'), do: false

  def casos([{parametro, ext}|t]) do
    mapa = %{
      PPP => ext,
      QQQ => 6,
      RRR => 3.6,
    }
    arr = [parametro, parametro]
    tpl = (1, 2, 3)
    true
  end

  def recorrido(arr, condicion) do
    if condicion do
      Enum.map(arr, fn v -> v+1 end) |> Enum.filter(fn v -> f > 5 end)
    else
      [h|t] = arr
      if h != 5 do
        IO.puts h
      end
      arrN = arr ++ [5]
      if Enum.member?(arrN, 8) do
        true
      end
      false
    end
  end

  def error() do
    nil
    true
    false
    :atomo
    1
    "hola"
    'mundo'
    2.7
  end

  @modulo
  ~N[2901-12-02 13:56:09:09]
  ~~~expresion
  left && right
  left &&& right
  left ||| right
  left <<< right
  left :: right
  a => b -> c != d == e <> f

end
