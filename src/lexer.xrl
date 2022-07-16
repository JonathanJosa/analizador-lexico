Definitions.

Rules.
\t : skip_token.
\n|\s|\r :  {token, textC(TokenLine, TokenChars)}.
[0-9]+ : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
[\(\)\{\}\[\]] : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\:][a-zA-Z0-9]+ : {token, atom(TokenLine, TokenChars)}.
[\&][\&]+ : {token, bitwise(TokenLine, TokenChars)}.
[\|\~\^\<\>][\|\~\^\<\>][\|\~\^\<\>] : {token, bitwise(TokenLine, TokenChars)}.
[A-Z][a-zA-Z]+[\.] : {token, funcion(TokenLine, TokenChars)}.
[a-zA-Z][\?a-zA-Z0-9\:]* :  {token, analyze(TokenLine, TokenChars)}.
[|][>] :  {token, analyze(TokenLine, TokenChars)}.
[\+\-\!\*\%\,\=\>\.\_\|\/\'\"\~\&\<\:] :  {token, analyze(TokenLine, TokenChars)}.
[#][\sa-zA-Z0-9\,\.\+\-\*\/\%]* :  {token, comentario(TokenLine, TokenChars)}.
[@][a-zA-Z0-9]+ : {token, module(TokenLine, TokenChars)}.
[~][A-Z][\[][0-9\-\:\s]+[\]] : {token, tiempo(TokenLine, TokenChars)}.


Erlang code.

atom(TokenLine, TokenChars) -> {atom, TokenLine, TokenChars}.

comentario(TokenLine, TokenChars) -> {comentario, TokenLine, TokenChars}.
textC(TokenLine, TokenChars) -> {textC, TokenLine, TokenChars}.
module(TokenLine, TokenChars) -> {module, TokenLine, TokenChars}.
tiempo(TokenLine, TokenChars) -> {tiempo, TokenLine, TokenChars}.
bitwise(TokenLine, TokenChars) -> {bitwise, TokenLine, TokenChars}.
funcion(TokenLine, TokenChars) -> {funcion, TokenLine, TokenChars}.


analyze(TokenLine, TokenChars) ->
    PipeLine = lists:member(TokenChars, ["|>"]),
    DotCmm = lists:member(TokenChars, [".", ","]),
    Booleano = lists:member(TokenChars, ["true", "false", "nil"]),
    KeyWrd = lists:member(TokenChars, ["defmodule", "do", "do:", "use", "def", "end", "fn", "-", "+", "if", "else", "=", "!", ">", "<", ":","=>", "==", "!=", "<>"]),
    if
        PipeLine -> {pipe, TokenLine, TokenChars};
        DotCmm -> {dot, TokenLine, TokenChars};
        KeyWrd -> {keyword, TokenLine, TokenChars};
        Booleano -> {bool, TokenLine, TokenChars};
        true -> {identifier, TokenLine, TokenChars}
    end.
