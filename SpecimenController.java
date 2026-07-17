package com.aimane.amr.api;

import com.aimane.amr.api.dto.CreateSpecimenRequest;
import com.aimane.amr.domain.Specimen;
import com.aimane.amr.repository.OrganismRepository;
import com.aimane.amr.repository.SpecimenRepository;
import jakarta.validation.Valid;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/specimens")
public class SpecimenController {
    private final SpecimenRepository specimens;
    private final OrganismRepository organisms;

    public SpecimenController(SpecimenRepository specimens, OrganismRepository organisms) {
        this.specimens = specimens;
        this.organisms = organisms;
    }

    @GetMapping
    public Page<Specimen> list(@RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "25") int size) {
        int safeSize = Math.min(Math.max(size, 1), 200);
        return specimens.findAllByOrderByCollectionDateDesc(PageRequest.of(Math.max(page, 0), safeSize));
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Specimen create(@Valid @RequestBody CreateSpecimenRequest request) {
        var organism = organisms.findById(request.organismId())
                .orElseThrow(() -> new IllegalArgumentException("Unknown organism id: " + request.organismId()));
        return specimens.save(Specimen.builder()
                .patientReference(request.patientReference())
                .organism(organism)
                .collectionDate(request.collectionDate())
                .ward(request.ward())
                .specimenType(request.specimenType())
                .build());
    }
}
