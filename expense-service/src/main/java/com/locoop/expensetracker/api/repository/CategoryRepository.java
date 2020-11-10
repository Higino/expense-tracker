package com.locoop.expensetracker.api.repository;

import com.locoop.expensetracker.api.model.Category;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    Category findByName(String name);
}
