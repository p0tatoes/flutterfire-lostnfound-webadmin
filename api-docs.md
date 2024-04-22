# Firestore API Documentation

## Collection/Table for Lost-n-Found items: `items`

## Document Structure

```javascript
{
    category: string,
    name: string,
    description: string,
    time_found: Timestamp,      // Unique type in Firestore, can be converted to JS Date with methods
    location_found: string,
    image: string,
    claimed: boolean
}
```

- if `category` is jewelry or money
    - just remove image

```javascript
{
    category: string,
    name: string,
    description: string,
    time_found: Timestamp,      // Unique type in Firestore, can be converted to Dart date with methods or constructors
    location_found: string,
    claimed: boolean
}
```