package com.aimane.amr.api;

import com.aimane.amr.domain.Antibiotic;
import com.aimane.amr.domain.Organism;
import com.aimane.amr.repository.AntibioticRepository;
import com.aimane.amr.repository.OrganismRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reference")
public class ReferenceController {
    private final OrganismRepository organisms;
    private final AntibioticRepository antibiotics;

    public ReferenceController(OrganismRepository organisms, AntibioticRepository antibiotics) {
        this.organisms = organisms;
        this.antibiotics = antibiotics;
    }

    @GetMapping("/organisms")
    public List<Organism> organisms() { return organisms.findAllByOrderByNameAsc(); }

    @GetMapping("/antibiotics")
    public List<Antibiotic> antibiotics() { return antibiotics.findAllByOrderByNameAsc(); }
}
