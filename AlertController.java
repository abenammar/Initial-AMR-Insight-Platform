package com.aimane.amr.api;

import com.aimane.amr.api.dto.UpdateAlertStatusRequest;
import com.aimane.amr.domain.ClinicalAlert;
import com.aimane.amr.repository.ClinicalAlertRepository;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/alerts")
public class AlertController {
    private final ClinicalAlertRepository alerts;
    public AlertController(ClinicalAlertRepository alerts) { this.alerts = alerts; }

    @GetMapping
    public List<ClinicalAlert> list() { return alerts.findAllByOrderByCreatedAtDesc(); }

    @PatchMapping("/{id}/status")
    public ClinicalAlert updateStatus(@PathVariable Long id, @Valid @RequestBody UpdateAlertStatusRequest request) {
        var alert = alerts.findById(id).orElseThrow(() -> new IllegalArgumentException("Unknown alert id: " + id));
        alert.setStatus(request.status());
        return alerts.save(alert);
    }
}
