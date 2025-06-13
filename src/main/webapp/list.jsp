<%-- 
    Document   : list
    Created on : May 3, 2025, 10:41:53 AM
    Author     : Rappchn
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daftar Kendaraan</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css"/>
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
                <li class="nav-item"><a class="nav-link active" href="listKendaraan"><i class="bi bi-card-list"></i> Data Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="tambahTransaksi"><i class="bi bi-cash-coin"></i> Buat Transaksi</a></li>
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
            <h5 class="mb-0"><i class="bi bi-card-list"></i> Daftar Kendaraan</h5>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <div class="table-responsive">
                <table id="kendaraanTable" class="table table-striped table-bordered">
                    <thead class="table-light">
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
                                <td>Rp <c:out value="${k.hargaSewaPerHari}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${k.tersedia}">
                                            <span class="badge bg-success">Tersedia</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Tidak Tersedia</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tombol Tambah -->
            <div class="mt-3 text-end">
                <a href="tambahKendaraan" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Tambah Kendaraan
                </a>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
        $('#kendaraanTable').DataTable({
            language: {
                search: "Cari:",
                lengthMenu: "Tampilkan _MENU_ data",
                info: "Menampilkan _START_ sampai _END_ dari _TOTAL_ data",
                paginate: {
                    first: "Pertama",
                    last: "Terakhir",
                    next: "Berikutnya",
                    previous: "Sebelumnya"
                },
                zeroRecords: "Tidak ada data ditemukan",
                infoEmpty: "Tidak ada data",
                infoFiltered: "(difilter dari _MAX_ total data)"
            }
        });
    });
</script>
</body>
</html>
