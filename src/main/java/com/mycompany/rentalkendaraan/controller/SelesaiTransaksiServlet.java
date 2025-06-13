/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

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
import com.mycompany.rentalkendaraan.model.DatabaseConnection;

/**
 *
 * @author Rappchn
 */
@WebServlet(name = "SelesaiTransaksiServlet", urlPatterns = {"/SelesaiTransaksiServlet"})
public class SelesaiTransaksiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idTransaksi = request.getParameter("id");

        if (idTransaksi == null || idTransaksi.isEmpty()) {
            response.getWriter().println("ID Transaksi tidak valid.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {

            // Ambil id_kendaraan berdasarkan id_transaksi
            String idKendaraan = null;
            PreparedStatement stmtSelect = conn.prepareStatement(
                    "SELECT id_kendaraan FROM transaksi WHERE id_transaksi = ?");
            stmtSelect.setString(1, idTransaksi);
            ResultSet rs = stmtSelect.executeQuery();

            if (rs.next()) {
                idKendaraan = rs.getString("id_kendaraan");
            } else {
                response.getWriter().println("Transaksi tidak ditemukan.");
                return;
            }

            // Update status transaksi jadi "Done"
            PreparedStatement stmtUpdate = conn.prepareStatement(
                    "UPDATE transaksi SET status = 'Done' WHERE id_transaksi = ?");
            stmtUpdate.setString(1, idTransaksi);
            stmtUpdate.executeUpdate();

            // Set kendaraan jadi tersedia kembali
            PreparedStatement stmtUpdateKendaraan = conn.prepareStatement(
                    "UPDATE kendaraan SET tersedia = 1 WHERE id_kendaraan = ?");
            stmtUpdateKendaraan.setString(1, idKendaraan);
            stmtUpdateKendaraan.executeUpdate();

            response.sendRedirect("dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal menyelesaikan transaksi: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Arahkan POST ke GET untuk kemudahan
    }

    @Override
    public String getServletInfo() {
        return "Menandai transaksi selesai dan membuat kendaraan tersedia kembali";
    }
}


