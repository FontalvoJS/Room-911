<template>
    <!-- Filter Section -->
    <div class="filter-section">
        <div class="input-group mb-3">
            <input
                type="text"
                class="form-control"
                placeholder="Search by employee ID"
                aria-label="Search by employee ID"
                v-model="filters.employee_id"
                @change="applyFilters"
            />
            <input
                type="text"
                class="form-control"
                placeholder="Search by firstname"
                aria-label="Search by firstname"
                v-model="filters.name"
                @change="applyFilters"
            />
            <input
                type="text"
                class="form-control"
                placeholder="Search by lastname"
                aria-label="Search by lastname"
                v-model="filters.last_name"
                @change="applyFilters"
            />
            <select
                class="form-select"
                v-model="filters.department"
                @change="applyFilters"
            >
                <option value="" selected>Select a department</option>
                <option
                    v-for="department in departments"
                    :key="department.id"
                    :value="department.id"
                >
                    {{ department.name }}
                </option>
            </select>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label for="initial-access-date" class="form-label">
                    Initial access date:
                </label>
                <input
                    @change="applyFilters"
                    type="date"
                    class="form-control"
                    id="initial-access-date"
                    v-model="filters.initialAccessDate"
                />
            </div>
            <div class="col-md-4">
                <label for="final-access-date" class="form-label">
                    Final access date:
                </label>
                <input
                    @change="applyFilters"
                    type="date"
                    class="form-control"
                    id="final-access-date"
                    v-model="filters.finalAccessDate"
                />
            </div>
        </div>
        <div class="row">
            <div class="col-md-1">
                <button class="btn btn-dark mt-2" @click="clearFilters">Clear</button>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: "FilterComponent",
    props: {
        departments: {
            type: Array,
            required: true,
        },
        filters: {
            type: Object,
            required: true,
        },
        employees: {
            type: Array,
            required: true,
        },
        applyFilters: {
            type: Function,
            required: true,
        },
        clearFilters: {
            type: Function,
            required: true,
        },
    },
};
</script>
