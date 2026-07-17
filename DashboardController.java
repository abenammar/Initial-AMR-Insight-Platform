package com.aimane.amr.api;

import com.aimane.amr.service.DashboardService;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {
    private final DashboardService dashboard;
    public DashboardController(DashboardService dashboard) { this.dashboard = dashboard; }

    @GetMapping("/summary")
    public Map<String, Object> summary() { return dashboard.summary(); }

    @GetMapping("/susceptibility")
    public List<Map<String, Object>> susceptibility(
            @RequestParam(defaultValue = "Acinetobacter species") String organism) {
        return dashboard.susceptibility(organism);
    }

    @GetMapping("/resistance-trend")
    public List<Map<String, Object>> resistanceTrend(
            @RequestParam(defaultValue = "Acinetobacter species") String organism,
            @RequestParam(defaultValue = "Meropenem") String antibiotic) {
        return dashboard.resistanceTrend(organism, antibiotic);
    }

    @GetMapping("/consumption-yearly")
    public List<Map<String, Object>> consumptionYearly() { return dashboard.consumptionYearly(); }

    @GetMapping("/top-antibiotics")
    public List<Map<String, Object>> topAntibiotics() { return dashboard.topAntibiotics(); }

    @GetMapping("/organisms")
    public List<Map<String, Object>> organisms() { return dashboard.organismOptions(); }
}
