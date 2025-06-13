<%-- 
    Document   : transaksi
    Created on : May 16, 2025, 11:35:01 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Tambah Transaksi</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
    <div class="container-fluid">
        <img src="logonavbar.png" alt="Logo" width="60" height="60" class="d-inline-block align-text-top">
        <a class="navbar-brand fw-bold" href="dashboard">Berkah Rent</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="tambahKendaraan"><i class="bi bi-plus-circle"></i> Input Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="listKendaraan"><i class="bi bi-card-list"></i> Data Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link active" href="tambahTransaksi"><i class="bi bi-cash-coin"></i> Buat Transaksi</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/laporan"><i class="bi bi-file-earmark-text"></i> Laporan</a></li>
            </ul>
            <span class="navbar-text me-3">Welcome, ${sessionScope.namaAdmin}!</span>
        </div>
    </div>
</nav>

<!-- Container -->
<div class="container">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="bi bi-cash-coin"></i> Tambah Transaksi</h5>
        </div>
        <div class="card-body">
            <form action="tambahTransaksi" method="post">
                <div class="mb-3">
                    <label for="idTransaksi" class="form-label">ID Transaksi</label>
                    <input type="text" class="form-control" name="idTransaksi" required>
                </div>

                <div class="mb-3">
                    <label for="namaPelanggan" class="form-label">Nama Pelanggan</label>
                    <input type="text" class="form-control" name="namaPelanggan" required>
                </div>

                <div class="mb-3">
                    <label for="idKendaraan" class="form-label">Pilih Kendaraan</label>
                    <select name="idKendaraan" class="form-select" required>
                        <option value="">-- Pilih Kendaraan --</option>
                        <c:forEach var="k" items="${kendaraanList}">
                            <option value="${k.id_kendaraan}">
                                ${k.model} - ${k.tahun} - ${k.plat_nomor}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="tanggalPinjam" class="form-label">Tanggal Pinjam</label>
                        <input type="date" class="form-control" name="tanggalPinjam" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="tanggalKembali" class="form-label">Tanggal Kembali</label>
                        <input type="date" class="form-control" name="tanggalKembali" required>
                    </div>
                </div>

                <!-- Admin session data -->
                <input type="hidden" name="idAdmin" value="${sessionScope.idAdmin}" />

                <div class="text-end">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-save"></i> Simpan Transaksi
                    </button>
                </div>
            </form>

            <!-- Debug info (opsional, bisa dihapus) -->
            <div class="mt-3 text-muted small">
                <p><i class="bi bi-person-circle"></i> ID Admin: ${sessionScope.idAdmin}</p>
                <p><i class="bi bi-person-lines-fill"></i> Nama Admin: ${sessionScope.namaAdmin}</p>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

