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
    const categories = await allCategories();
    const expenses = await allExpenses();
    return res.json({ categories, expenses });
})


app.listen(3000);