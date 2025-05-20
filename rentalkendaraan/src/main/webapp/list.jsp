<%-- 
    Document   : list
    Created on : May 3, 2025, 10:41:53 AM
    Author     : Rappchn
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Daftar Kendaraan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #f2f2f2;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ccc;
        }

        .navbar .menu {
            display: flex;
            gap: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f9f9f9;
        }
        
        .btn {
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="navbar">
    <a href="dashboard"><div><strong>Brand Name</strong></div></a>
    <div class="menu">
        <a href="tambahKendaraan">Input Kendaraan</a>
        <a href="listKendaraan">Data Kendaraan</a>
        <a href="tambahTransaksi">Buat Transaksi</a>
        <a href="#">Laporan</a>
        <input type="hidden" name="idAdmin" value="${sessionScope.idAdmin}" />
        <span>Welcome, ${sessionScope.namaAdmin}!</span>

    </div>
    </div>
        <h2 style="text-align: center" >Daftar Kendaraan</h2>

    <!-- Tampilkan pesan error jika ada -->
    <c:if test="${not empty errorMessage}">
        <div style="color:red">${errorMessage}</div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Merek</th>
            <th>Model</th>
            <th>Tahun</th>
            <th>Plat Nomor</th>
            <th>Harga Sewa/Hari</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="k" items="${listKendaraan}">
            <tr>
                <td><c:out value="${k.idKendaraan}" /></td>
                <td><c:out value="${k.merek}" /></td>
                <td><c:out value="${k.model}" /></td>
                <td><c:out value="${k.tahun}" /></td>
                <td><c:out value="${k.platNomor}" /></td>
                <td><c:out value="${k.hargaSewaPerHari}" /></td>
                <td><c:out value="${k.tersedia ? 'Tersedia' : 'Tidak Tersedia'}" /></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <br>
    <!-- comment <a href="tambah.jsp">Tambah Kendaraan Lagi</a>-->
    <a href="tambahKendaraan" class="btn">Tambah Kendaraan</a>
</body>
</html>


