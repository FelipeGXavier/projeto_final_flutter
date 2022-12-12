const knex = require('./databaseConnection');

const createNewExpense = (expense) => {
    return knex('expense').insert(expense);
}

const allCategories = async () => {
    const categories = (await knex('expense_category').select("*")).map(el => {
        return { value: el.id, label: el.category };
    });
    return categories;
}

const allExpenses = () => {
    return knex('expense').innerJoin(
        'expense_category',
        'expense.category_id',
        '=',
        'expense_category.id'
    ).select("*");
}

module.exports.createNewExpense = createNewExpense;
module.exports.allCategories = allCategories;
module.exports.allExpenses = allExpenses;