/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
/**
 *
 * @author Rappchn
 */
@WebServlet("/editTransaksi")
public class EditTransaksiServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM transaksi WHERE id_transaksi = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("transaksi", rs);
                request.getRequestDispatcher("editTransaksi.jsp").forward(request, response);
            } else {
                response.getWriter().println("Data transaksi tidak ditemukan.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal menampilkan form edit: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idTransaksi = request.getParameter("idTransaksi");
            String namaPelanggan = request.getParameter("namaPelanggan");
            LocalDate tanggalPinjam = LocalDate.parse(request.getParameter("tanggalPinjam"));
            LocalDate tanggalKembali = LocalDate.parse(request.getParameter("tanggalKembali"));
            String idKendaraan = request.getParameter("idKendaraan");

            try (Connection conn = DatabaseConnection.getConnection()) {
                int hargaPerHari = 0;
                PreparedStatement stmtHarga = conn.prepareStatement(
                    "SELECT harga_sewa_per_hari FROM kendaraan WHERE id_kendaraan = ?");
                stmtHarga.setString(1, idKendaraan);
                ResultSet rsHarga = stmtHarga.executeQuery();
                if (rsHarga.next()) {
                    hargaPerHari = rsHarga.getInt("harga_sewa_per_hari");
                }
                
                long lamaPinjam = ChronoUnit.DAYS.between(tanggalPinjam, tanggalKembali);
                if (lamaPinjam <= 0) lamaPinjam = 1;
                int newHarga = (int) lamaPinjam * hargaPerHari;
                
                PreparedStatement stmt = conn.prepareStatement(
                    "UPDATE transaksi SET nama_pelanggan=?, tanggal_pinjam=?, tanggal_kembali=?, total_harga=? WHERE id_transaksi=?");
                stmt.setString(1, namaPelanggan);
                stmt.setDate(2, Date.valueOf(tanggalPinjam));
                stmt.setDate(3, Date.valueOf(tanggalKembali));
                stmt.setInt(4, newHarga);
                stmt.setString(5, idTransaksi);

                stmt.executeUpdate();
                response.sendRedirect("dashboard");
                
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal mengedit transaksi: " + e.getMessage());
        }
    }
}
