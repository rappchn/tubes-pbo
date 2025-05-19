/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.model;
import java.util.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author Rappchn
 */




public class Transaksi {
    private String idTransaksi;
    private String namaPelanggan;
    private String jenisKendaraan;      // contoh: Avanza, Innova (dari field `model`)
    private String nomorKendaraan;      // dari field `plat_nomor`
    private LocalDate tanggalPinjam;
    private LocalDate tanggalKembali;
    private int totalHarga;            // dihitung = selisih hari * harga_sewa_per_hari
    private String status;
    private Admin admin;               // admin yang membuat transaksi

    public Transaksi() {}

    public Transaksi(String idTransaksi, String namaPelanggan, String jenisKendaraan,
                     String nomorKendaraan, LocalDate tanggalPinjam, LocalDate tanggalKembali,
                     int hargaSewaPerHari, Admin admin) {
        this.idTransaksi = idTransaksi;
        this.namaPelanggan = namaPelanggan;
        this.jenisKendaraan = jenisKendaraan;
        this.nomorKendaraan = nomorKendaraan;
        this.tanggalPinjam = tanggalPinjam;
        this.tanggalKembali = tanggalKembali;
        this.totalHarga = hitungTotalHarga(tanggalPinjam, tanggalKembali, hargaSewaPerHari);
        this.admin = admin;
    }

    private int hitungTotalHarga(LocalDate pinjam, LocalDate kembali, int hargaPerHari) {
    long selisihHari = ChronoUnit.DAYS.between(pinjam, kembali);
    return (int) selisihHari * hargaPerHari;
    }

    // Getters dan Setters

    public String getIdTransaksi() {
        return idTransaksi;
    }

    public void setIdTransaksi(String idTransaksi) {
        this.idTransaksi = idTransaksi;
    }

    public String getNamaPelanggan() {
        return namaPelanggan;
    }

    public void setNamaPelanggan(String namaPelanggan) {
        this.namaPelanggan = namaPelanggan;
    }

    public String getJenisKendaraan() {
        return jenisKendaraan;
    }

    public void setJenisKendaraan(String jenisKendaraan) {
        this.jenisKendaraan = jenisKendaraan;
    }

    public String getNomorKendaraan() {
        return nomorKendaraan;
    }

    public void setNomorKendaraan(String nomorKendaraan) {
        this.nomorKendaraan = nomorKendaraan;
    }

    public LocalDate getTanggalPinjam() {
        return tanggalPinjam;
    }

    public void setTanggalPinjam(LocalDate tanggalPinjam) {
        this.tanggalPinjam = tanggalPinjam;
    }

    public LocalDate getTanggalKembali() {
        return tanggalKembali;
    }

    public void setTanggalKembali(LocalDate tanggalKembali) {
        this.tanggalKembali = tanggalKembali;
    }

    public int getTotalHarga() {
        return totalHarga;
    }

    public void setTotalHarga(int totalHarga) {
        this.totalHarga = totalHarga;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
    
    
}


