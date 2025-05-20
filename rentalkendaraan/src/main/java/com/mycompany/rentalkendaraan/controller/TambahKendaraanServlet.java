/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/tambahKendaraan")
public class TambahKendaraanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO kendaraan (id_kendaraan, jenis, merek, model, tahun, plat_nomor, harga_sewa_per_hari, tersedia, jumlah_kursi, ada_ac, transmisi, driver_mobil, kapasitas_penumpang, driver_bus, kapasitas_mesin, jenis_motor) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            String tipe = request.getParameter("tipe");

            stmt.setString(1, request.getParameter("id"));
            stmt.setString(2, tipe);
            stmt.setString(3, request.getParameter("merek"));
            stmt.setString(4, request.getParameter("model"));
            stmt.setString(5, request.getParameter("tahun"));
            stmt.setString(6, request.getParameter("plat_nomor"));
            stmt.setDouble(7, Double.parseDouble(request.getParameter("harga")));
            stmt.setBoolean(8, true); // tersedia

            if ("mobil".equals(tipe)) {
                stmt.setInt(9, parseIntOrNull(request.getParameter("kursi")));
                stmt.setBoolean(10, true); // bisa ditingkatkan dari form checkbox
                stmt.setString(11, request.getParameter("transmisi"));
                stmt.setString(12, request.getParameter("driver"));
                stmt.setNull(13, java.sql.Types.INTEGER);
                stmt.setNull(14, java.sql.Types.VARCHAR);
                stmt.setNull(15, java.sql.Types.INTEGER);
                stmt.setNull(16, java.sql.Types.VARCHAR);
            } else if ("bus".equals(tipe)) {
                stmt.setNull(9, java.sql.Types.INTEGER);
                stmt.setNull(10, java.sql.Types.BOOLEAN);
                stmt.setNull(11, java.sql.Types.VARCHAR);
                stmt.setNull(12, java.sql.Types.VARCHAR);
                stmt.setInt(13, parseIntOrNull(request.getParameter("kapasitas")));
                stmt.setString(14, request.getParameter("driver"));
                stmt.setNull(15, java.sql.Types.INTEGER);
                stmt.setNull(16, java.sql.Types.VARCHAR);
            } else if ("motor".equals(tipe)) {
                stmt.setNull(9, java.sql.Types.INTEGER);
                stmt.setNull(10, java.sql.Types.BOOLEAN);
                stmt.setNull(11, java.sql.Types.VARCHAR);
                stmt.setNull(12, java.sql.Types.VARCHAR);
                stmt.setNull(13, java.sql.Types.INTEGER);
                stmt.setNull(14, java.sql.Types.VARCHAR);
                stmt.setInt(15, parseIntOrNull(request.getParameter("cc")));
                stmt.setString(16, request.getParameter("jenis"));
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("listKendaraan");
            } else {
                response.getWriter().println("Gagal menambahkan kendaraan.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal menambahkan kendaraan: " + e.getMessage());
        }
    }

    private Integer parseIntOrNull(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("tambah.jsp").forward(request, response);
    }



}





