/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.DatabaseConnection;
import com.mycompany.rentalkendaraan.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validasi sederhana (bisa ditambahkan panjang minimal, karakter, dsb)
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username dan Password tidak boleh kosong.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Panggil fungsi register dari Admin.java
        boolean success = Admin.register(username, password);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            // Jika username sudah digunakan atau error lain
            request.setAttribute("error", "Registrasi gagal. Username mungkin sudah digunakan.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}


