package com.example.data_structures.controller;

import com.example.data_structures.service.DataStructureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

@RestController
@RequestMapping("/api/datastructures")
public class DataStructuresController {

    private final DataStructureService dataStructureService;

    @Autowired
    public DataStructuresController(DataStructureService dataStructureService) {
        this.dataStructureService = dataStructureService;
    }

    @GetMapping("/arrays")
    public Object[] getAllArrays() {
        return dataStructureService.getAllArrays();
    }

    @PostMapping("/arrays")
    public Object[] createArray(@RequestBody Object[] array) {
        return dataStructureService.createArray(array);
    }

    @GetMapping("/strings")
    public List<String> getAllStrings() {
        return dataStructureService.getAllStrings();
    }

    @PostMapping("/strings")
    public List<String> createString(@RequestBody String str) {
        return dataStructureService.createString(str);
    }

    @GetMapping("/lists")
    public List<Object> getAllLists() {
        return dataStructureService.getAllLists();
    }

    @PostMapping("/lists")
    public List<Object> createList(@RequestBody List<Object> list) {
        return dataStructureService.createList(list);
    }

    @GetMapping("/queues")
    public Queue<Object> getAllQueues() {
        return dataStructureService.getAllQueues();
    }

    @PostMapping("/queues")
    public Queue<Object> createQueue(@RequestBody Queue<Object> queue) {
        return dataStructureService.createQueue(queue);
    }

    @GetMapping("/maps")
    public Map<Object, Object> getAllMaps() {
        return dataStructureService.getAllMaps();
    }

    @PostMapping("/maps")
    public Map<Object, Object> createMap(@RequestBody Map<Object, Object> map) {
        return dataStructureService.createMap(map);
    }

    @GetMapping("/sets")
    public Set<Object> getAllSets() {
        return dataStructureService.getAllSets();
    }

    @PostMapping("/sets")
    public Set<Object> createSet(@RequestBody Set<Object> set) {
        return dataStructureService.createSet(set);
    }
}
