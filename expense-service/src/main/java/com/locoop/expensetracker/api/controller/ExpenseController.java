package com.locoop.expensetracker.api.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import com.locoop.expensetracker.api.model.Expense;
import com.locoop.expensetracker.api.repository.ExpenseRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ExpenseController {

    @Autowired
    private ExpenseRepository expenseRepo;

    @GetMapping("/expenses")
    public List<Expense> getExpenses(){
        return expenseRepo.findAll();
    }

    @GetMapping("/expense/{id}")
    public ResponseEntity<Expense> getExpense(@PathVariable Long id) {
        Optional<Expense> result = expenseRepo.findById(id);
        return result.map(response -> ResponseEntity.ok().body(response)).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    @DeleteMapping("/expense/{id}")
    public ResponseEntity<?> deleteExpense(@PathVariable Long id) {
        expenseRepo.deleteById(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/expense")
    public ResponseEntity<Expense> createExpenses(@Valid @RequestBody Expense expense) throws URISyntaxException {
        Expense result = expenseRepo.save(expense);
        URI redirect = new URI("/api/expenses" + result.getId()) ;
        return ResponseEntity.created( redirect ).body(result);
    }
}
