<%-- 
    Document   : laporan
    Created on : Jun 13, 2025, 2:32:35 PM
    Author     : Rappchn
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Laporan Transaksi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container-fluid">
        <img src="logonavbar.png" alt="Logo" width="60" height="60" class="d-inline-block align-text-top">
        <a class="navbar-brand fw-bold" href="dashboard">Berkah Rent</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="tambahKendaraan"><i class="bi bi-plus-circle"></i> Input Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="listKendaraan"><i class="bi bi-card-list"></i> Data Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="tambahTransaksi"><i class="bi bi-cash-coin"></i> Buat Transaksi</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/laporan"><i class="bi bi-file-earmark-text"></i> Laporan</a></li>
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

<!-- Content -->
<div class="container mt-4">
    <h2 class="mb-4">Laporan Transaksi</h2>

    <!-- Form Filter -->
    <form method="get" class="row g-3 mb-4">
        <div class="col-md-3">
            <label class="form-label">Tanggal Mulai</label>
            <input type="date" name="start" class="form-control" value="${param.start}">
        </div>
        <div class="col-md-3">
            <label class="form-label">Tanggal Akhir</label>
            <input type="date" name="end" class="form-control" value="${param.end}">
        </div>
        <div class="col-md-3">
            <label class="form-label">Status</label>
            <select name="status" class="form-select">
                <option value="">Semua</option>
                <option value="Done" ${param.status == 'Done' ? 'selected' : ''}>Done</option>
                <option value="Berlangsung" ${param.status == 'Berlangsung' ? 'selected' : ''}>Berlangsung</option>
            </select>
        </div>
        <div class="col-md-3 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100"><i class="bi bi-funnel-fill"></i> Filter</button>
        </div>
    </form>

    <!-- Total Pendapatan -->
    <div class="mb-3">
        <h5>Total Pendapatan: <span class="text-success">Rp. <fmt:formatNumber value="${totalPendapatan}" type="number" groupingUsed="true" /></span></h5>
    </div>

    <!-- Chart -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-white fw-bold">
            Grafik Pendapatan Harian
        </div>
        <div class="card-body">
            <canvas id="chartPendapatan" height="100"></canvas>
        </div>
    </div>

    <!-- Tabel Transaksi -->
    <div class="card shadow-sm">
        <div class="card-header bg-white fw-bold">Detail Transaksi</div>
        <div class="card-body">
            <table id="tabelLaporan" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID Transaksi</th>
                        <th>Nama Pelanggan</th>
                        <th>Kendaraan</th>
                        <th>Plat Nomor</th>
                        <th>Tgl Pinjam</th>
                        <th>Tgl Kembali</th>
                        <th>Status</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="trx" items="${transaksiList}">
                        <tr>
                            <td>${trx.id_transaksi}</td>
                            <td>${trx.nama_pelanggan}</td>
                            <td>${trx.model}</td>
                            <td>${trx.plat_nomor}</td>
                            <td>${trx.tanggal_pinjam}</td>
                            <td>${trx.tanggal_kembali}</td>
                            <td>${trx.status}</td>
                            <td>Rp. <fmt:formatNumber value="${trx.total_harga}" type="number" groupingUsed="true" /></td>
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
        $('#tabelLaporan').DataTable();
    });

    const labels = ${labelsJson};
    const data = ${dataJson};
    const ctx = document.getElementById('chartPendapatan').getContext('2d');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Pendapatan',
                data: data,
                borderColor: 'rgba(75, 192, 192, 1)',
                fill: true,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let value = context.parsed.y.toLocaleString('id-ID');
                            return 'Rp. ' + value;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return 'Rp. ' + value.toLocaleString('id-ID');
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
