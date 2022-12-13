const knex = require('./databaseConnection');

const createNewExpense = (expense) => {
    return knex('expense').insert(expense);
}

const createNewCategory = (category) => {
    return knex('expense_category').insert(category).returning("id");
}

const deleteCategory = (categoryId) => {
    try {
        return knex('expense_category').where('id', categoryId).del()
    } catch (e) {
        console.error(e);
    }
}

const allCategories = async () => {
    const categories = (await knex('expense_category').select("*")).map(el => {
        return { value: el.id, label: el.category };
    });
    return categories;
}

const allExpenses = (filter) => {
    let whereClause = "created_at:: date = now():: date";
    if (filter != null) {
        whereClause = "created_at::date >= date_trunc('month', CURRENT_DATE)";
    }
    return knex('expense').innerJoin(
        'expense_category',
        'expense.category_id',
        '=',
        'expense_category.id'
    ).select("*")
        .whereRaw(whereClause);

}

module.exports.createNewExpense = createNewExpense;
module.exports.allCategories = allCategories;
module.exports.allExpenses = allExpenses;
module.exports.createNewCategory = createNewCategory;
module.exports.deleteCategory = deleteCategory;