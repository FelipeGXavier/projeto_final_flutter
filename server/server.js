const express = require('express');
var cors = require('cors');
const { createNewExpense, allCategories, allExpenses, createNewCategory, deleteCategory } = require('./expenseDao');

const app = express();

app.use(cors({ origin: '*' }));

app.use(express.json());


app.post('/expense', async (req, res) => {
    const { title, type, value, category } = req.body;
    await createNewExpense({ title, type, value, category_id: category.id })
    return res.json({ ok: true });
})

app.post('/category', async (req, res) => {
    const { category } = req.body;
    const categoryId = await createNewCategory({ category });
    return res.json({ id: categoryId[0].id, category });
})

app.delete('/category/:id', async (req, res) => {
    await deleteCategory(req.params.id);
    return res.json({ ok: true });
})

app.get('/expenses', async (req, res) => {
    const filter = req.query.filter || null;
    const expenses = await allExpenses(filter);
    return res.json({ expenses });
})

app.get('/current-balance', async (req, res) => {
    const filter = req.query.filter || null;
    const expenses = await allExpenses(filter);
    const balance = expenses.reduce((prev, current) => {
        if (current.type) {
            return prev + current.value;
        } else {
            return prev - current.value;
        }
    }, 0);
    console.log(balance)
    return res.json({ balance });
})

app.get('/categories', async (req, res) => {
    const categories = await allCategories();
    return res.json({ categories });
})


app.listen(3000);