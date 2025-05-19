/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.model;

/**
 *
 * @author Rappchn
 */
public class Mobil extends Kendaraan implements Driver {
    private int jumlahKursi;
    private String transmisi;
    private String namaDriver;

    public Mobil(String idKendaraan, String merek, String model, String tahun, String platNomor, double hargaSewaPerHari,
                 int jumlahKursi, String transmisi, String namaDriver) {
        super(idKendaraan, merek, model, tahun, platNomor, hargaSewaPerHari);
        this.jumlahKursi = jumlahKursi;
        this.transmisi = transmisi;
        this.namaDriver = namaDriver;
    }

    @Override
    public void setDriver(String namaDriver) {
        this.namaDriver = namaDriver;
    }

    @Override
    public String getDriver() {
        return namaDriver;
    }

    public String getDetail() {
        return getInfo() + ", Kursi: " + jumlahKursi + ", Transmisi: " + transmisi + ", Driver: " + namaDriver;
    }
}
