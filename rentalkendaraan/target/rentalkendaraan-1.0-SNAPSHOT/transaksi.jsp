<%-- 
    Document   : transaksi
    Created on : May 16, 2025, 11:35:01 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Tambah Transaksi</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .form-container { max-width: 600px; margin: auto; }
        form { display: flex; flex-direction: column; gap: 10px; }
        input, select, button { padding: 8px; }
        label { font-weight: bold; }
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
    <div class="form-container">
        <h2>Tambah Transaksi</h2>
        <form action="tambahTransaksi" method="post">
            <label for="idTransaksi">ID Transaksi</label>
            <input type="text" name="idTransaksi" required>

            <label for="namaPelanggan">Nama Pelanggan</label>
            <input type="text" name="namaPelanggan" required>

            <label for="idKendaraan">Pilih Kendaraan</label>
            <select name="idKendaraan" required>
                <c:forEach var="k" items="${kendaraanList}">
                    <option value="${k.id_kendaraan}">
                        ${k.model} - ${k.tahun} - ${k.plat_nomor}
                    </option>
                </c:forEach>
            </select>

            <label for="tanggalPinjam">Tanggal Pinjam</label>
            <input type="date" name="tanggalPinjam" required>

            <label for="tanggalKembali">Tanggal Kembali</label>
            <input type="date" name="tanggalKembali" required>

            <!-- ID Admin disisipkan dari session -->
            <input type="hidden" name="idAdmin" value="${sessionScope.idAdmin}" />
            <p>Session Admin ID: ${sessionScope.idAdmin}</p>
            <p>Session Admin ID: ${sessionScope.namaAdmin}</p>


            <button type="submit">Simpan Transaksi</button>
        </form>
    </div>
</body>
</html>

