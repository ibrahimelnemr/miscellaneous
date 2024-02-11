import java.util.*;

public class DataStructures {
    public static void main(String[] args) {
        
        int[] arr = {1, 2, 3, 4, 5};
        System.out.println("array: " + Arrays.toString(arr));

        
        String str = "Hello World";
        System.out.println("string: " + str);
        System.out.println("string length: " + str.length());
        System.out.println("substring from index 7: " + str.substring(7));
        System.out.println("character at index 1: " + str.charAt(1));

        
        List<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(2);
        list.add(3);
        System.out.println("list: " + list);
        System.out.println("element at index 1: " + list.get(1));
        list.remove(1);
        System.out.println("after removing element at index 1: " + list);

        
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        queue.offer(2);
        queue.offer(3);
        System.out.println("queue: " + queue);
        System.out.println("element at front of queue: " + queue.peek());
        System.out.println("queue size: " + queue.size());
        queue.poll();
        System.out.println("queue after polling: " + queue);

        
        Map<String, Integer> map = new HashMap<>();
        map.put("one", 1);
        map.put("two", 2);
        map.put("three", 3);
        System.out.println("map: " + map);
        System.out.println("value forkey 'two': " + map.get("two"));
        System.out.println("contains key 'four': " + map.containsKey("four"));
        map.remove("two");
        System.out.println("after removing key 'two': " + map);

        
        Set<Integer> set = new HashSet<>();
        set.add(1);
        set.add(2);
        set.add(3);
        System.out.println("set: " + set);
        System.out.println("contains element 2: " + set.contains(2));
        set.remove(2);
        System.out.println("set after removing element 2: " + set);
    }
}
