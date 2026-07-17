package com.aimane.amr.api.dto;

import com.aimane.amr.domain.WorkflowStatus;
import jakarta.validation.constraints.NotNull;

public record UpdateAlertStatusRequest(@NotNull WorkflowStatus status) {}
