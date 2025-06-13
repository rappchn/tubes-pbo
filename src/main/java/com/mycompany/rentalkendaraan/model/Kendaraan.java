/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.model;
/**
 *
 * @author Rappchn
 */
public class Kendaraan {
    private String idKendaraan;
    private String merek;
    private String model;
    private String tahun;
    private String platNomor;
    private double hargaSewaPerHari;
    private boolean tersedia;

    public Kendaraan(String idKendaraan, String merek, String model, String tahun, String platNomor, double hargaSewaPerHari) {
        this.idKendaraan = idKendaraan;
        this.merek = merek;
        this.model = model;
        this.tahun = tahun;
        this.platNomor = platNomor;
        this.hargaSewaPerHari = hargaSewaPerHari;
        this.tersedia = true;
    }

    public String getIdKendaraan() {
        return idKendaraan;
    }

    public String getMerek() {
        return merek;
    }

    public String getModel() {
        return model;
    }

    public String getTahun() {
        return tahun;
    }

    public String getPlatNomor() {
        return platNomor;
    }

    public double getHargaSewaPerHari() {
        return hargaSewaPerHari;
    }

    public boolean isTersedia() {
        return tersedia;
    }

    public void setTersedia(boolean tersedia) {
        this.tersedia = tersedia;
    }

    public double hitungHargaSewa(int hari) {
        return hargaSewaPerHari * hari;
    }

    public String getInfo() {
        return merek + " " + model + " (" + tahun + ") - " + platNomor;
    }
}