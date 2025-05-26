package com.bilbaoskp.model;

public class Centro {
    private int codCentro;
    private String nombre;
    private String responsable;
    private String tipoCentro;
	private int numAlumnos;
    private String email;
    private String telefono;
    private int idSuscriptor; // Relacion con la tabla suscriptores
    private String password;

    // Constructores
    public Centro() {
    }

    public Centro(int codCentro, String nombre, String responsable, String tipoCentro,
			int numAlumnos, String email, String telefono, String password) {
		super();
		this.codCentro = codCentro;
		this.nombre = nombre;
		this.responsable = responsable;
		this.tipoCentro = tipoCentro;
		this.numAlumnos = numAlumnos;
		this.email = email;
		this.telefono = telefono;
		this.password = password;
	}



	// Getters y Setters
    public int getCodCentro() {
        return codCentro;
    }

    public void setCodCentro(int codCentro) {
        this.codCentro = codCentro;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getResponsable() {
		return responsable;
	}

	public void setResponsable(String responsable) {
		this.responsable = responsable;
	}
    
    public String getTipoCentro() {
		return tipoCentro;
	}

	public void setTipoCentro(String tipoCentro) {
		this.tipoCentro = tipoCentro;
	}

    public int getNumAlumnos() {
        return numAlumnos;
    }

    public void setNumAlumnos(int numAlumnos) {
        this.numAlumnos = numAlumnos;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public int getIdSuscriptor() {
        return idSuscriptor;
    }

    public void setIdSuscriptor(int idSuscriptor) {
        this.idSuscriptor = idSuscriptor;
    }

    public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
    public String toString() {
        return "Centro{" +
                "codCentro=" + codCentro +
                ", nombre='" + nombre + '\'' +
                ", localidad='" +  '\'' +
                ", etapasEducativas='" +
                ", numAlumnos=" + numAlumnos +
                ", email='" + email + '\'' +
                ", idSuscriptor=" + idSuscriptor +
                '}';
    }
}