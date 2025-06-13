/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.model;

/**
 *
 * @author Rappchn
 */
public class Motor extends Kendaraan {
    private int kapasitasMesin;
    private String jenis;

    public Motor(String idKendaraan, String merek, String model, String tahun, String platNomor, double hargaSewaPerHari,
                 int kapasitasMesin, String jenis) {
        super(idKendaraan, merek, model, tahun, platNomor, hargaSewaPerHari);
        this.kapasitasMesin = kapasitasMesin;
        this.jenis = jenis;
    }

    public String getDetail() {
        return getInfo() + ", Mesin: " + kapasitasMesin + "cc, Jenis: " + jenis;
    }
}
