/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prueba;

import dao.CategoriaDAO;
/**
 *
 * @author GamingWorld
 */
public class PruebaInsert {
    public static void main(String[] args) {
        CategoriaDAO dao = new CategoriaDAO();
        
        String nuevaCategoria = "Ciencia Ficción"; 
        
        boolean exito = dao.registrarCategoria(nuevaCategoria);
        
        if (exito) {
            System.out.println("✅ ¡La categoría '" + nuevaCategoria + "' se guardó en Supabase!");
        } else {
            System.out.println("❌ Hubo un error al guardar.");
        }
    }
}
