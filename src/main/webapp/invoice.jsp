<%-- 
    Document   : invoice
    Created on : May 31, 2025, 10:05:15 PM
    Author     : Rappchn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%
    ResultSet trx = (ResultSet) request.getAttribute("transaksi");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice Transaksi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: auto;
        }
        h1 {
            text-align: center;
        }
        .invoice-detail p {
            margin: 8px 0;
        }
        .button-container {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<h1>INVOICE TRANSAKSI</h1>

<div class="invoice-detail">
    <p>KONTOL</p>
    <p><strong>ID Transaksi:</strong> <%= trx.getString("id_transaksi") %></p>
    <p><strong>Nama Pelanggan:</strong> <%= trx.getString("nama_pelanggan") %></p>
    <p><strong>Kendaraan:</strong> <%= trx.getString("model") %></p>
    <p><strong>Nomor Kendaraan:</strong> <%= trx.getString("plat_nomor") %></p>
    <p><strong>Tanggal Pinjam:</strong> <%= trx.getDate("tanggal_pinjam") %></p>
    <p><strong>Tanggal Kembali:</strong> <%= trx.getDate("tanggal_kembali") %></p>
    <p><strong>Status:</strong> <%= trx.getString("status") %></p>
    <p><strong>Admin:</strong> <%= trx.getString("nama_admin") %></p>
    <p><strong>Total Harga:</strong> Rp.<%= String.format("%,d", trx.getInt("total_harga")).replace(",", ".") %></p>
</div>

<div class="button-container">
    <a href="invoice?id=<%= trx.getString("id_transaksi") %>&format=pdf" target="_blank">
        <button type="button">Cetak PDF</button>
    </a>
</div>

</body>
</html>

