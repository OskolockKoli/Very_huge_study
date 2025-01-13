const numbers = [0, 5, 4, 12, -1, 0, 1, 2, 3, -2];

document.getElementById('array').textContent = numbers.join(', ');
function filterArray(arr, callback) {
    let result = [];
    for(let i = 0; i < arr.length; i++) {
        if(callback(arr[i])) {
            result.push(arr[i]);
        }
    }
    return result;
}
async function fetchData(url) {
    const response = await fetch(url);

    if (response.ok) {
        const data = await response.text();
        return data;
    } else {
        throw new Error(`Ошибка: ${response.status}`);
    }
}
document.getElementById('evenNumbers').addEventListener('click', () => {
    const isEven = num => num % 2 === 0;
    const result = filterArray(numbers, isEven);
    document.getElementById('outputArray').textContent = 'Фильтрованный массив: ' + result.join(', ');
});

document.getElementById('notEvenNumbers').addEventListener('click', () => {
    const isNotEven = num => num % 2 !== 0;
    const result = filterArray(numbers, isNotEven);
    document.getElementById('outputArray').textContent = 'Фильтрованный массив: ' + result.join(', ');
});

document.getElementById('fetchDataButton').addEventListener('click', async () => {
    const url = document.getElementById('urlExample').value;    fetchData(url)
        .then(data => {
            console.log('Данные:', data);
            document.getElementById('outputURL').textContent = 'Данные: ' + data;

        })

        .catch(error => {
            console.error('Ошибка:', error);
            document.getElementById('outputURL').textContent = 'Ошибка: ' + error.message;
        });
});
