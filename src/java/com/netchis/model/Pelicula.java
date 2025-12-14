/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.netchis.model;

/**
 *
 * @author GamingWorld
 */
public class Pelicula {
    
    // Atributos
    private int id;
    private String titulo;
    private String descripcion;
    private int duracion;
    private String urlPortada;
    private int anio;
    private double precioAlquiler;
    private int idCategoria; 

    // Constructor Vacío (Importante para el DAO y Servlet)
    public Pelicula() {}

    // Constructor Completo (Actualizado para incluir idCategoria)
    public Pelicula(int id, String titulo, String descripcion, int duracion, String urlPortada, int anio, double precioAlquiler, int idCategoria) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.duracion = duracion;
        this.urlPortada = urlPortada;
        this.anio = anio;
        this.precioAlquiler = precioAlquiler;
        this.idCategoria = idCategoria;
    }

    // --- Getters y Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public int getDuracion() { return duracion; }
    public void setDuracion(int duracion) { this.duracion = duracion; }

    public String getUrlPortada() { return urlPortada; }
    public void setUrlPortada(String urlPortada) { this.urlPortada = urlPortada; }

    public int getAnio() { return anio; }
    public void setAnio(int anio) { this.anio = anio; }

    public double getPrecioAlquiler() { return precioAlquiler; }
    public void setPrecioAlquiler(double precioAlquiler) { this.precioAlquiler = precioAlquiler; }
    
    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
    
    // Opcional: toString para depuración en consola
    @Override
    public String toString() {
        return "Pelicula{id=" + id + ", titulo=" + titulo + "}";
    }
}
