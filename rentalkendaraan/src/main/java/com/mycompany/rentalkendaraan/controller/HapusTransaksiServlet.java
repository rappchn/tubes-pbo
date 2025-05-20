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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Rappchn
 */
@WebServlet("/hapusTransaksi")
public class HapusTransaksiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idTransaksi = request.getParameter("id");

        try (Connection conn = DatabaseConnection.getConnection()) {

            // 1. Ambil id_kendaraan berdasarkan transaksi
            String idKendaraan = null;
            PreparedStatement selectStmt = conn.prepareStatement(
                "SELECT id_kendaraan FROM transaksi WHERE id_transaksi = ?"
            );
            selectStmt.setString(1, idTransaksi);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                idKendaraan = rs.getString("id_kendaraan");
            } else {
                response.getWriter().println("Transaksi tidak ditemukan.");
                return;
            }

            // 2. Update kendaraan menjadi tersedia kembali
            if (idKendaraan != null) {
                PreparedStatement updateKendaraan = conn.prepareStatement(
                    "UPDATE kendaraan SET tersedia = 1 WHERE id_kendaraan = ?"
                );
                updateKendaraan.setString(1, idKendaraan);
                updateKendaraan.executeUpdate();
            }

            // 3. Hapus transaksi
            PreparedStatement deleteStmt = conn.prepareStatement(
                "DELETE FROM transaksi WHERE id_transaksi = ?"
            );
            deleteStmt.setString(1, idTransaksi);
            int rows = deleteStmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("dashboard");
            } else {
                response.getWriter().println("Gagal menghapus transaksi.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal menghapus transaksi: " + e.getMessage());
        }
    }
}

