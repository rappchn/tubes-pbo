/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.model;

/**
 *
 * @author Rappchn
 */
public class Bus extends Kendaraan implements Driver {
    private int kapasitasPenumpang;
    private String namaDriver;

    public Bus(String idKendaraan, String merek, String model, String tahun, String platNomor, double hargaSewaPerHari,
               int kapasitasPenumpang, String namaDriver) {
        super(idKendaraan, merek, model, tahun, platNomor, hargaSewaPerHari);
        this.kapasitasPenumpang = kapasitasPenumpang;
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
        return getInfo() + ", Kapasitas: " + kapasitasPenumpang + ", Driver: " + namaDriver;
    }
}
