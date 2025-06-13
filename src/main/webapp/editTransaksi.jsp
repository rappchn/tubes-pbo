<%-- 
    Document   : editTransaksi
    Created on : May 20, 2025, 7:11:32 PM
    Author     : Rappchn
--%>

<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    ResultSet trx = (ResultSet) request.getAttribute("transaksi");
%>
<form action="editTransaksi" method="post">
    <input type="hidden" name="idTransaksi" value="<%= trx.getString("id_transaksi") %>" />
    <input type="hidden" name="idKendaraan" value="<%= trx.getString("id_kendaraan") %>" />

    Nama Pelanggan: <input type="text" name="namaPelanggan" value="<%= trx.getString("nama_pelanggan") %>" /><br>
    Tanggal Pinjam: <input type="date" name="tanggalPinjam" value="<%= trx.getDate("tanggal_pinjam") %>" /><br>
    Tanggal Kembali: <input type="date" name="tanggalKembali" value="<%= trx.getDate("tanggal_kembali") %>" /><br>
    
    <input type="submit" value="Simpan Perubahan" />
</form>

