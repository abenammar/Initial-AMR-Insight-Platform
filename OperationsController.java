package com.aimane.amr.api;

import com.aimane.amr.domain.Deployment;
import com.aimane.amr.domain.WorkItem;
import com.aimane.amr.repository.DeploymentRepository;
import com.aimane.amr.repository.WorkItemRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api")
public class OperationsController {
    private final DeploymentRepository deployments;
    private final WorkItemRepository workItems;

    public OperationsController(DeploymentRepository deployments, WorkItemRepository workItems) {
        this.deployments = deployments;
        this.workItems = workItems;
    }

    @GetMapping("/deployments")
    public List<Deployment> deployments() { return deployments.findAllByOrderByServiceNameAsc(); }

    @GetMapping("/work-items")
    public List<WorkItem> workItems() { return workItems.findAllByOrderByIdAsc(); }
}
