/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;
import com.mycompany.rentalkendaraan.model.DatabaseConnection;
import com.mycompany.rentalkendaraan.model.Kendaraan;    // pastikan ini sesuai nama class model-mu
import com.mycompany.rentalkendaraan.model.Transaksi;


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
/**
 *
 * @author Rappchn
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DatabaseConnection.getConnection()) {

            // Jumlah transaksi
            PreparedStatement stmt1 = conn.prepareStatement("SELECT COUNT(*) FROM transaksi");
            ResultSet rs1 = stmt1.executeQuery();
            rs1.next();
            request.setAttribute("jumlahTransaksi", rs1.getInt(1));

            // Transaksi selesai
            PreparedStatement stmt2 = conn.prepareStatement("SELECT COUNT(*) FROM transaksi WHERE status = 'Done'");
            ResultSet rs2 = stmt2.executeQuery();
            rs2.next();
            request.setAttribute("transaksiSelesai", rs2.getInt(1));

            // Sewa sedang berlangsung
            PreparedStatement stmt3 = conn.prepareStatement("SELECT COUNT(*) FROM transaksi WHERE status = 'On Going'");
            ResultSet rs3 = stmt3.executeQuery();
            rs3.next();
            request.setAttribute("sewaBerlangsung", rs3.getInt(1));

            // Riwayat transaksi terbaru
            PreparedStatement stmt4 = conn.prepareStatement(
                "SELECT t.id_transaksi, t.nama_pelanggan, k.model, k.plat_nomor, " +
                "t.tanggal_pinjam, t.tanggal_kembali, t.total_harga, t.status " +
                "FROM transaksi t " +
                "JOIN kendaraan k ON t.id_kendaraan = k.id_kendaraan " +
                "ORDER BY t.tanggal_pinjam DESC LIMIT 50"
            );
            ResultSet rs4 = stmt4.executeQuery();

            List<Transaksi> riwayat = new ArrayList<>();
            while (rs4.next()) {
                Transaksi tr = new Transaksi();
                tr.setIdTransaksi(rs4.getString("id_transaksi"));
                tr.setNamaPelanggan(rs4.getString("nama_pelanggan"));
                tr.setJenisKendaraan(rs4.getString("model"));
                tr.setNomorKendaraan(rs4.getString("plat_nomor"));
                tr.setTanggalPinjam(rs4.getDate("tanggal_pinjam").toLocalDate());
                tr.setTanggalKembali(rs4.getDate("tanggal_kembali").toLocalDate());
                tr.setTotalHarga(rs4.getInt("total_harga"));
                tr.setStatus(rs4.getString("status"));
                riwayat.add(tr);
            }
            request.setAttribute("riwayatTransaksi", riwayat);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Terjadi kesalahan: " + e.getMessage());
        }
    }
}



