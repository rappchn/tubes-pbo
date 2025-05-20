<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tambah Kendaraan</title>
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
    </style>
    <script>
        function tampilkanFormTambahan() {
            var tipe = document.getElementById("tipe").value;
            document.getElementById("form-mobil").style.display = "none";
            document.getElementById("form-bus").style.display = "none";
            document.getElementById("form-motor").style.display = "none";

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
<h2>Tambah Kendaraan</h2>
<form action="tambahKendaraan" method="post">
    Tipe:
    <select name="tipe" id="tipe" onchange="tampilkanFormTambahan()" required>
        <option value="">-- Pilih --</option>
        <option value="mobil">Mobil</option>
        <option value="bus">Bus</option>
        <option value="motor">Motor</option>
    </select><br><br>

    ID: <input type="text" name="id" required><br>
    Merek: <input type="text" name="merek" required><br>
    Model: <input type="text" name="model" required><br>
    Tahun: <input type="text" name="tahun" required><br>
    Plat Nomor: <input type="text" name="plat_nomor" required><br>
    Harga Sewa per Hari: <input type="number" name="harga" step="0.01" required><br><br>

    <div id="form-mobil" style="display:none">
        Jumlah Kursi: <input type="number" name="kursi"><br>
        Transmisi: <input type="text" name="transmisi"><br>
        Driver: <input type="text" name="driver"><br>
    </div>

    <div id="form-bus" style="display:none">
        Kapasitas Penumpang: <input type="number" name="kapasitas"><br>
        Driver: <input type="text" name="driver"><br>
    </div>

    <div id="form-motor" style="display:none">
        Kapasitas Mesin (cc): <input type="number" name="cc"><br>
        Jenis: <input type="text" name="jenis"><br>
    </div><br>

    <input type="submit" value="Tambah">
</form>

</body>
</html>
