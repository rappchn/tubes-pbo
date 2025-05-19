package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.DatabaseConnection;
import com.mycompany.rentalkendaraan.model.Kendaraan;    // pastikan ini sesuai nama class model-mu

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;                             // tambahkan import ini
import java.sql.SQLException;
import java.util.ArrayList;                             // tambahkan import ini
import java.util.List;                                  // dan ini

@WebServlet("/listKendaraan")
public class ListKendaraanServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Kendaraan> list = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM kendaraan";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Sesuaikan dengan konstruktor terbaru class Kendaraan
                Kendaraan kendaraan = new Kendaraan(
                    rs.getString("id_kendaraan"),
                    rs.getString("merek"),
                    rs.getString("model"),
                    rs.getString("tahun"),
                    rs.getString("plat_nomor"),
                    rs.getDouble("harga_sewa_per_hari")
                );
                kendaraan.setTersedia(rs.getBoolean("tersedia")); // jika field ini ada di tabel
                list.add(kendaraan);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Terjadi kesalahan saat mengambil data kendaraan: " + e.getMessage());
        }

        request.setAttribute("listKendaraan", list);
        request.getRequestDispatcher("list.jsp").forward(request, response);
    }
}
