const express = require('express');
var cors = require('cors');
const { createNewExpense, allCategories, allExpenses } = require('./expenseDao');

const app = express();

app.use(cors({ origin: '*' }));

app.use(express.json());


app.post('/expense', async (req, res) => {
    const { title, type, value, category } = req.body;
    await createNewExpense({ title, type, value, category_id: category.id })
    return res.json({ ok: true });
})

app.get('/expenses', async (req, res) => {
    const expenses = await allExpenses();
    return res.json({ expenses });
})

app.get('/current-balance', async (req, res) => {
    const expenses = await allExpenses();
    const balance = expenses.reduce((prev, current) => {
        if (current.type) {
            return current.value + prev;
        } else {
            return current.value - prev;
        }
    }, 0);
    return res.json({ balance });
})

app.get('/categories', async (req, res) => {
    const categories = await allCategories();
    return res.json({ categories });
})


app.listen(3000);