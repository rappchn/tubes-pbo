<%-- 
    Document   : index
    Created on : May 4, 2025, 5:39:36 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dashboard Admin</title>
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

        .dashboard-container {
            padding: 20px;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            flex: 1;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
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
    <div><strong>Brand Name</strong></div>
    <div class="menu">
        <a href="#">Dashboard</a>
        <a href="listKendaraan">Data Kendaraan</a>
        <a href="tambahTransaksi">Sewa Kendaraan</a>
        <a href="#">Laporan</a>
        <span>Welcome, Admin!</span>
    </div>
</div>

<div class="dashboard-container">
    <h2>Dashboard</h2>

    <div class="cards">
        <div class="card">
            <div>👤</div>
            <div>Jumlah Pelanggan</div>
            <div><strong>${jumlahPelanggan}</strong></div>
        </div>
        <div class="card">
            <div>📊</div>
            <div>Jumlah Transaksi</div>
            <div><strong>${jumlahTransaksi}</strong></div>
        </div>
        <div class="card">
            <div>ℹ️</div>
            <div>Sewa Berlangsung</div>
            <div><strong>${sewaBerlangsung}</strong></div> <!-- ✅ -->
        </div>
        <div class="card">
            <div>✅</div>
            <div>Transaksi Selesai</div>
            <div><strong>${transaksiSelesai}</strong></div> <!-- ✅ -->
        </div>
    </div>

    <h3>Riwayat Transaksi</h3>
    <table>
        <thead>
            <tr>
                <th>ID Transaksi</th>
                <th>Pelanggan</th>
                <th>Jenis Kendaraan</th>
                <th>Nomor Kendaraan</th>
                <th>Tgl Pinjam</th>
                <th>Tgl selesai</th>
                <th>Total</th>
                <th>Status</th>
                <th>Invoice</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="trx" items="${riwayatTransaksi}" varStatus="status">
                <tr>
                    <td>${trx.idTransaksi}</td>
                    <td>${trx.namaPelanggan}</td>
                    <td>${trx.jenisKendaraan}</td>
                    <td>${trx.nomorKendaraan}</td>
                    <td>${trx.tanggalPinjam}</td>
                    <td>${trx.tanggalKembali}</td>
                    <td>${trx.totalHarga}</td>
                    <td>${trx.status}</td>
                    <td>
                        <a href="CetakInvoiceServlet?id=${trx.idTransaksi}" class="btn" target="_blank">Cetak Invoice</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
