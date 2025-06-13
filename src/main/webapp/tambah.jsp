<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tambah Kendaraan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script>
        function tampilkanFormTambahan() {
            document.getElementById("form-mobil").style.display = "none";
            document.getElementById("form-bus").style.display = "none";
            document.getElementById("form-motor").style.display = "none";
            let tipe = document.getElementById("tipe").value;
            if (tipe === "mobil") {
                document.getElementById("form-mobil").style.display = "block";
            } else if (tipe === "bus") {
                document.getElementById("form-bus").style.display = "block";
            } else if (tipe === "motor") {
                document.getElementById("form-motor").style.display = "block";
            }
        }
    </script>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <img src="logonavbar.png" alt="Logo" width="60" height="60" class="d-inline-block align-text-top">
        <a class="navbar-brand fw-bold" href="dashboard">Berkah Rent</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="tambahKendaraan"><i class="bi bi-plus-circle"></i> Input Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="listKendaraan"><i class="bi bi-card-list"></i> Data Kendaraan</a></li>
                <li class="nav-item"><a class="nav-link" href="tambahTransaksi"><i class="bi bi-cash-coin"></i> Buat Transaksi</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/laporan"><i class="bi bi-file-earmark-text"></i> Laporan</a></li>
            </ul>
            <span class="navbar-text me-3">Welcome, ${sessionScope.namaAdmin}!</span>
        </div>
    </div>
</nav>

<!-- Form Container -->
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="bi bi-plus-circle"></i> Tambah Kendaraan</h5>
        </div>
        <div class="card-body">
            <form action="tambahKendaraan" method="post">
                <input type="hidden" name="idAdmin" value="${sessionScope.idAdmin}" />

                <div class="mb-3">
                    <label for="tipe" class="form-label">Tipe Kendaraan</label>
                    <select name="tipe" id="tipe" class="form-select" onchange="tampilkanFormTambahan()" required>
                        <option value="">-- Pilih Tipe --</option>
                        <option value="mobil">Mobil</option>
                        <option value="bus">Bus</option>
                        <option value="motor">Motor</option>
                    </select>
                </div>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">ID Kendaraan</label>
                        <input type="text" name="id" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Merek</label>
                        <input type="text" name="merek" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Model</label>
                        <input type="text" name="model" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tahun</label>
                        <input type="text" name="tahun" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Plat Nomor</label>
                        <input type="text" name="plat_nomor" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Harga Sewa per Hari</label>
                        <input type="number" name="harga" class="form-control" step="0.01" required>
                    </div>
                </div>

                <!-- Form Tambahan -->
                <div id="form-mobil" style="display:none;" class="mt-4 border-top pt-3">
                    <h6 class="text-primary">Detail Mobil</h6>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Jumlah Kursi</label>
                            <input type="number" name="kursi" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Transmisi</label>
                            <input type="text" name="transmisi" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Driver</label>
                            <input type="text" name="driver" class="form-control">
                        </div>
                    </div>
                </div>

                <div id="form-bus" style="display:none;" class="mt-4 border-top pt-3">
                    <h6 class="text-success">Detail Bus</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Kapasitas Penumpang</label>
                            <input type="number" name="kapasitas" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Driver</label>
                            <input type="text" name="driver" class="form-control">
                        </div>
                    </div>
                </div>

                <div id="form-motor" style="display:none;" class="mt-4 border-top pt-3">
                    <h6 class="text-warning">Detail Motor</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Kapasitas Mesin (cc)</label>
                            <input type="number" name="cc" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Jenis</label>
                            <input type="text" name="jenis" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="mt-4 text-end">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Tambah</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
