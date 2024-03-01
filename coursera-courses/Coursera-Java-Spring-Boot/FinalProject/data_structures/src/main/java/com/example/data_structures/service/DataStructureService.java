package com.example.data_structures.service;

import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class DataStructureService {

    
    private List<Object[]> arrays = new ArrayList<>();

    public Object[] createArray(Object[] array) {
        arrays.add(array);
        return array;
    }

    public Object[] getAllArrays() {
        return arrays.toArray(new Object[0]);
    }

    
    private List<String> strings = new ArrayList<>();

    public List<String> createString(String str) {
        strings.add(str);
        return strings;
    }

    public List<String> getAllStrings() {
        return new ArrayList<>(strings);
    }

    
    private List<List<Object>> lists = new ArrayList<>();

    public List<Object> createList(List<Object> list) {
        lists.add(list);
        return list;
    }

    public List<Object> getAllLists() {
        return new ArrayList<>(lists);
    }

    
    private Queue<Object> queue = new LinkedList<>();

    public Queue<Object> createQueue(Queue<Object> q) {
        queue.addAll(q);
        return queue;
    }

    public Queue<Object> getAllQueues() {
        return new LinkedList<>(queue);
    }

    
    private Map<Object, Object> map = new HashMap<>();

    public Map<Object, Object> createMap(Map<Object, Object> m) {
        map.putAll(m);
        return map;
    }

    public Map<Object, Object> getAllMaps() {
        return new HashMap<>(map);
    }

    // Set CRUD operations
    private Set<Object> set = new HashSet<>();

    public Set<Object> createSet(Set<Object> s) {
        set.addAll(s);
        return set;
    }

    public Set<Object> getAllSets() {
        return new HashSet<>(set);
    }
}
