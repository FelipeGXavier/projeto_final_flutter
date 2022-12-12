/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async function (knex) {
    await knex.schema
        .createTableIfNotExists('expense', function (table) {
            table.increments('id');
            table.string('title').notNullable();
            table.boolean('type');
            table.double('value');
            table.dateTime('created_at').defaultTo(knex.fn.now());
            table.integer('category_id').unsigned();
            table.foreign('category_id').references('id').inTable('expense_category');
        })

};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
    return knex.schema
        .dropTableIfExists("expense")
};
