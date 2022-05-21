echo off
D:\Programs\GnuWin32\bin\flex lexmini.l
echo "FLEX compilo la especificación lexica del archivo lexmini.l (Se creo un archivo lex.yy.c)"
pause
D:\Programs\MinGW\mingw64\bin\gcc.exe lex.yy.c -o Compilado.exe
echo "Finalizo la ejecución del compilador C sobre el archivo lex.yy.c (Se creo un archivo Compilado.exe)"
pause
Compilado.exe Prueba.txt
echo "Se ejecuto el analizador lexico sobre el archivo Prueba.txt"
@REM del lex.yy.c
@REM del Compilado.exe
echo "Se borraron los archivos generados en todo este proceso, finalizando..."
pause