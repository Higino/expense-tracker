package com.locoop.expensetracker.api.repository;

import com.locoop.expensetracker.api.model.Expense;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpenseRepository extends JpaRepository<Expense, Long> {


}
