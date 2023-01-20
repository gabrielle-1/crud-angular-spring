package com.gabrielle.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
@Entity
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("_id")
    private long id;

    @NotNull
    @NotBlank
    @Length(min = 5, max = 100)
    @Column(name = "nome", length = 100, nullable = false)
    private String name;

    @NotNull
    @NotBlank
    @Length(max = 12)
    @Pattern(regexp = "Back-end|Front-end")
    @Column(name = "categoria", length = 12, nullable = false)
    private String category;

    @NotNull
    @NotBlank
    @Length(max = 10)
    @Pattern(regexp = "Ativo|Inativo")
    @Column(length = 10, nullable = false)
    private String status = "Ativo";

    public String getName() {
        return this.name;
    }

    public String getCategory() {
        return this.category;
    }

    public String getStatus() {
        return this.status;
    }

    public long getId() {
        return this.id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
