package com.aimane.amr.api.dto;

import jakarta.validation.constraints.*;
import java.time.LocalDate;

public record CreateSpecimenRequest(
        @NotBlank String patientReference,
        @NotNull Long organismId,
        @NotNull @PastOrPresent LocalDate collectionDate,
        @NotBlank String ward,
        @NotBlank String specimenType) {}
