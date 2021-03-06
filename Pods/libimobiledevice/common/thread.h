/*
 * thread.h
 *
 * Copyright (c) 2012 Martin Szulecki All Rights Reserved.
 * Copyright (c) 2012 Nikias Bassen All Rights Reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA 
 */

#ifndef __THREAD_H
#define __THREAD_H

#ifdef WIN32
#include <windows.h>
typedef HANDLE thread_t;
typedef CRITICAL_SECTION mutex_t;
#else
#include <pthread.h>
typedef pthread_t thread_t;
typedef pthread_mutex_t mutex_t;
#endif

typedef void* (*thread_func_t)(void* data);

int create_thread(thread_t* thread, thread_func_t thread_func, void* data);
void thread_join(thread_t thread);

void mutex_init(mutex_t* mutex);
void mutex_destroy(mutex_t* mutex);
void mutex_lock(mutex_t* mutex);
void mutex_unlock(mutex_t* mutex);

#endif
