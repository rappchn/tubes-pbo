<%-- 
    Document   : index
    Created on : May 4, 2025, 5:39:36 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container-fluid">
        <img src="logonavbar.png" alt="Logo" width="60" height="60" class="d-inline-block align-text-top">
        <a class="navbar-brand fw-bold" href="dashboard">
            
            Berkah Rent</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="tambahKendaraan"><i class="bi bi-plus-circle"></i> Input Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="listKendaraan"><i class="bi bi-card-list"></i> Data Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="tambahTransaksi"><i class="bi bi-cash-coin"></i> Buat Transaksi</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/laporan"><i class="bi bi-file-earmark-text"></i> Laporan</a></li>
            </ul>
            <div class="dropdown">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle"></i> ${sessionScope.namaAdmin}
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="container mt-4">
    <h2 class="mb-4">Dashboard</h2>

    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card shadow border-start-primary h-100 py-2">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-xs text-primary text-uppercase mb-1">Jumlah Pelanggan</div>
                        <div class="h5 fw-bold">${jumlahTransaksi}</div>
                    </div>
                    <i class="bi bi-people-fill fs-2 text-primary"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow border-start-success h-100 py-2">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-xs text-success text-uppercase mb-1">Jumlah Transaksi</div>
                        <div class="h5 fw-bold">${jumlahTransaksi}</div>
                    </div>
                    <i class="bi bi-receipt fs-2 text-success"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow border-start-info h-100 py-2">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-xs text-info text-uppercase mb-1">Sewa Berlangsung</div>
                        <div class="h5 fw-bold">${sewaBerlangsung}</div>
                    </div>
                    <i class="bi bi-hourglass-split fs-2 text-info"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow border-start-warning h-100 py-2">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-xs text-warning text-uppercase mb-1">Transaksi Selesai</div>
                        <div class="h5 fw-bold">${transaksiSelesai}</div>
                    </div>
                    <i class="bi bi-check-circle fs-2 text-warning"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabel Transaksi -->
    <div class="card shadow-sm">
        <div class="card-header bg-white fw-bold">
            Riwayat Transaksi
        </div>
        <div class="card-body">
            <table id="tabelTransaksi" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>ID Transaksi</th>
                        <th>Pelanggan</th>
                        <th>Jenis Kendaraan</th>
                        <th>Nomor Kendaraan</th>
                        <th>Tgl Pinjam</th>
                        <th>Tgl Selesai</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="trx" items="${riwayatTransaksi}">
                        <tr>
                            <td>${trx.idTransaksi}</td>
                            <td>${trx.namaPelanggan}</td>
                            <td>${trx.jenisKendaraan}</td>
                            <td>${trx.nomorKendaraan}</td>
                            <td>${trx.tanggalPinjam}</td>
                            <td>${trx.tanggalKembali}</td>
                            <td>Rp.<fmt:formatNumber value="${trx.totalHarga}" type="number" groupingUsed="true"/></td>   
                            <td>${trx.status}</td>
                            <td>
                                <a href="hapusTransaksi?id=${trx.idTransaksi}" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></a>
                                <a href="editTransaksi?id=${trx.idTransaksi}" class="btn btn-sm btn-warning" target="_blank"><i class="bi bi-pencil-square"></i></a>
                                <a href="SelesaiTransaksiServlet?id=${trx.idTransaksi}" class="btn btn-sm btn-success"><i class="bi bi-check2-circle"></i></a>
                                <a href="invoice?id=${trx.idTransaksi}&format=pdf" class="btn btn-sm btn-info" target="_blank"><i class="bi bi-printer"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
        $('#tabelTransaksi').DataTable({
            pageLength: 10, // default tampilkan 10 baris
            lengthMenu: [5, 10, 25, 50, 100],
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
