/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;


/**
 *
 * @author Rappchn
 */
@WebServlet("/laporan")
public class LaporanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String status = request.getParameter("status");

        List<Map<String, String>> transaksiList = new ArrayList<>();
        Map<String, Integer> pendapatanPerTanggal = new TreeMap<>();
        int totalPendapatan = 0;

        StringBuilder query = new StringBuilder(
            "SELECT t.id_transaksi, t.nama_pelanggan, t.tanggal_pinjam, t.tanggal_kembali, " +
            "t.status, k.model, k.plat_nomor, t.total_harga " +
            "FROM transaksi t JOIN kendaraan k ON t.id_kendaraan = k.id_kendaraan WHERE 1=1 "
        );

        if (start != null && !start.isEmpty()) {
            query.append(" AND t.tanggal_pinjam >= ?");
        }
        if (end != null && !end.isEmpty()) {
            query.append(" AND t.tanggal_kembali <= ?");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND t.status = ?");
        } else {
            query.append(" AND t.status = 'Done'");
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (start != null && !start.isEmpty()) {
                stmt.setString(paramIndex++, start);
            }
            if (end != null && !end.isEmpty()) {
                stmt.setString(paramIndex++, end);
            }
            if (status != null && !status.isEmpty()) {
                stmt.setString(paramIndex++, status);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id_transaksi", rs.getString("id_transaksi"));
                row.put("nama_pelanggan", rs.getString("nama_pelanggan"));
                row.put("tanggal_pinjam", rs.getString("tanggal_pinjam"));
                row.put("tanggal_kembali", rs.getString("tanggal_kembali"));
                row.put("status", rs.getString("status"));
                row.put("model", rs.getString("model"));
                row.put("plat_nomor", rs.getString("plat_nomor"));
                row.put("total_harga", String.valueOf(rs.getInt("total_harga")));
                transaksiList.add(row);

                if ("Done".equalsIgnoreCase(rs.getString("status"))) {
                    String tgl = rs.getString("tanggal_kembali");
                    int harga = rs.getInt("total_harga");
                    pendapatanPerTanggal.put(tgl, pendapatanPerTanggal.getOrDefault(tgl, 0) + harga);
                    totalPendapatan += harga;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Generate JSON strings for chart
        JSONArray labels = new JSONArray();
        JSONArray data = new JSONArray();
        for (Map.Entry<String, Integer> entry : pendapatanPerTanggal.entrySet()) {
            labels.put(entry.getKey());
            data.put(String.valueOf(entry.getValue()));

        }

        request.setAttribute("transaksiList", transaksiList);
        request.setAttribute("totalPendapatan", totalPendapatan);
        request.setAttribute("labelsJson", labels.toString());
        request.setAttribute("dataJson", data.toString());

        request.getRequestDispatcher("laporan.jsp").forward(request, response);
    }
}