<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Contenido Multimedia</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #555;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            border: none;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .back-button {
            margin-top: 10px;
            display: block;
            text-align: center;
            color: #333;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Agregar Nuevo Contenido</h2>
        <form action="guardarMultimedia.jsp" method="post">
            <label for="titulo">Título:</label>
            <input type="text" id="titulo" name="titulo" required>

            <label for="descripcion">Descripción:</label>
            <input type="text" id="descripcion" name="descripcion">

            <label for="url">URL del Archivo Multimedia:</label>
            <input type="text" id="url" name="url" required>

            <label for="tipo">Tipo de Archivo:</label>
            <select id="tipo" name="tipo" required>
                <option value="Imagen">Imagen</option>
                <option value="Video">Video</option>
                <option value="Audio">Audio</option>
            </select>

            <input type="submit" value="Guardar">
        </form>
        <a class="back-button" href="index.html">Volver al Menú Principal</a>
    </div>
</body>
</html>
